module Globales
  extend ActiveSupport::Concern
  included do
    set_constantes
    before_action :load_collection, only: :index
    before_action :load_item, only: [:show, :update, :destroy]
    before_action :build_item, only: :create
    wrap_parameters include: const_get('Params') | const_get('NestedParams')
  end
  # defino mis contantes
  class_methods do
    def set_constantes
      const_set('Resource',controller_path.classify.constantize)
      const_set('Element', controller_name.singularize.to_sym)
      const_set('NestedParams', const_get('Resource::PARAMS').to_s.scan(/:(\w+)_attributes/).flatten)
      const_set('Params', const_get('Resource::PARAMS'))
    end
  end

  private
  #metodo para evitar repetir self.class
  def sc
    self.class
  end

  def load_collection
    @collection = scoped
  end

  def new_item
    @item = sc::Resource.new
  end

  def item_params
    set_nested
    params.require(sc::Element).permit(*sc::Params)
  end
  
  def set_nested
    sc::NestedParams.each do |attr|
      unless params[sc::Element][attr.to_sym].blank?
        params[sc::Element][(attr+'_attributes').to_sym] = params[sc::Element][attr.to_sym]
        params[sc::Element].delete(attr)
        # params[:compra][:items_attributes].each do |item|
        #   item[:producto_id] = item[:producto][:id]
        #   item.delete("producto")
        # end
      end
    end
  end

end

module Globales::Empresa
  private
  def load_item
     @item = scoped.find(params[:id])
     @item.empresa_id = @empresa_id
  end

  def build_item
    @item = sc::Resource.new(item_params)
    @item.empresa_id = @empresa_id
  end

  def scoped
    sc::Resource.scoped(@empresa_id)
  end
end

module Globales::Usuario
  private
  def load_item
    @item = scoped.find(params[:id])
    @item.usuario_id = current_ba_usuario.id
  end

  def build_item
    @item = sc::Resource.new(item_params)
    @item.usuario_id = current_ba_usuario.id
  end

  def scoped
    sc::Resource.scoped(current_ba_usuario.id)
  end

end
