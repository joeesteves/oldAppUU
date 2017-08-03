class Ad::Auxiliar
  #el auxiliar contable contabiliza las operaciones
  def initialize args = {}
    @op = args[:operacion]
  end

  def contabiliza
    @op.asiento.destroy if @op.asiento
    asiento = Co::Asiento.new fecha: @op.fecha, moneda_id: 1, cotizacion: 1, empresa_id: @op.empresa_id, esgenerado: true

    asiento.items.build get_items
    if asiento.save
      @op.asiento_id = asiento.id
    else
      @op.errors.add :base, asiento.errors.full_messages.join(',')
      false
    end
  end

  private
    def get_items
      @op.detalle = {}
      items_ary = []
      last_cta = nil
      #importe de cada producto
      @op.items.each do |item|
        next if item._destroy
        last_cta = item.send(@op.class::K[:cta_prod]) || last_cta
        items_ary.push cuenta_id: last_cta, "#{@op.class::K[:origen]}": item.importe
        set_impuestos_in_detalle(item) if @op.empresa.cat_fiscal == 'repo'
      end

      @op.detalle.each do |k, v|
        items_ary.push cuenta_id: v[:cid], "#{@op.class::K[:origen]}": v[:importe] unless k == :exento
      end
      set_items_destino items_ary
      items_ary.sort_by! { |i| i[:haber] || 0 }
    end

    def set_items_destino items_ary
      cta_destino = @op.condiciones[0].cuenta_id || @op.class::K[:cta_cte_default]
      get_venc.each do |venc|
        items_ary.push cuenta_id: cta_destino, "#{@op.class::K[:destino]}": venc[:importe], venc: venc[:fecha]
      end
    end
    #devuelve en array de hsh [{importe: importe, venc: date}]
    def get_venc
      cond_pago = @op.condiciones[0].forma
      if match_rslt = cond_pago.match(/^[a-z](\d{1,2})/i)
        cond_pago = 'C' + match_rslt[1]
        set_cuotas match_rslt[1].to_i
      elsif cond_pago.match(/\d+:\d+/)
        scan_rslt = cond_pago.scan(/\d+:\d+/).flatten
        set_venc_irreg scan_rslt
      elsif cond_pago.scan(/(\d{1,3})(?:,|y)?{1,}/i)
        scan_rslt = cond_pago.scan(/(\d{1,3})(?:,|y)?{1,}/i).flatten
        set_venc_dias scan_rslt
      end
    end

    def set_cuotas cantidad
      rslt = []
      importe_acu = 0.00
      cantidad.times do |index|
        if (index+1) < cantidad
          importe = (@op.total/cantidad).round(2)
          importe_acu += importe
        else
          importe = (@op.total - importe_acu).round(2)
        end
        rslt.push({importe: importe, fecha: @op.fecha.advance(months: index)})
      end
      rslt
    end

    def set_venc_dias scan_rslt
      rslt = []
      importe_acu = 0.00
      cantidad = scan_rslt.length
      scan_rslt.each_with_index do |dias, index|
        dias = dias.to_i
        if (index+1) < cantidad
          importe = (@op.total/cantidad).round(2)
          importe_acu += importe
        else
          importe = (@op.total - importe_acu).round(2)
        end
        rslt.push({importe: importe, fecha: @op.fecha.advance(days: dias)})
      end
      rslt
    end
    def set_venc_irreg scan_rslt
      rslt = []
      importe_acu = 0.00
      cantidad = scan_rslt.length
      scan_rslt.each_with_index do |dia_porc, index|
        dias, porc = dia_porc.split(':')
        if (index+1) < cantidad
          importe = ((@op.total * porc.to_i)/100).round(2)
          importe_acu += importe
        else
          importe = (@op.total - importe_acu).round(2)
        end
        rslt.push({importe: importe, fecha: @op.fecha.advance(days: dias.to_i)})
      end
      rslt
    end

    def set_impuestos_in_detalle item
      imp = item.impuesto || item.producto.impuesto
      imp_nombre = imp[:nombre].parameterize.underscore.to_sym #ej: iva_21
      @op.detalle[imp_nombre] ||= {}
      @op.detalle[imp_nombre][:cid] ||= imp.send(@op.class::K[:cta_imp])
      @op.detalle[imp_nombre][:importe] ||= 0
      imp.coef += 1 if imp.coef == 0
      @op.detalle[imp_nombre][:importe] += ( imp.coef  * item.importe ).round(2)
    end

end
