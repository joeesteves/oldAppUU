# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160225143022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "ba_accesos", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "empresa_id"
    t.integer  "rol_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ba_accesos", ["empresa_id"], name: "index_ba_accesos_on_empresa_id", using: :btree
  add_index "ba_accesos", ["rol_id"], name: "index_ba_accesos_on_rol_id", using: :btree
  add_index "ba_accesos", ["usuario_id"], name: "index_ba_accesos_on_usuario_id", using: :btree

  create_table "ba_modelos", force: :cascade do |t|
    t.integer  "estado",     default: 1
    t.string   "nombre"
    t.text     "desc"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ba_organizaciones", force: :cascade do |t|
    t.integer  "estado",     default: 1
    t.string   "nombre"
    t.string   "id_fiscal"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "cat_fiscal"
  end

  create_table "ba_productos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "unidad"
    t.integer  "cta_compra_id"
    t.integer  "cta_venta_id"
    t.integer  "impuesto_id"
  end

  create_table "ba_relaciones", force: :cascade do |t|
    t.integer  "empresa_id"
    t.integer  "organizacion_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "tipo"
  end

  create_table "ba_roles", force: :cascade do |t|
    t.integer  "estado",      default: 1
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "ba_usuarios", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.hstore   "memoria",                default: {},      null: false
  end

  add_index "ba_usuarios", ["email"], name: "index_ba_usuarios_on_email", using: :btree
  add_index "ba_usuarios", ["memoria"], name: "index_ba_usuarios_on_memoria", using: :gin
  add_index "ba_usuarios", ["reset_password_token"], name: "index_ba_usuarios_on_reset_password_token", unique: true, using: :btree
  add_index "ba_usuarios", ["uid", "provider"], name: "index_ba_usuarios_on_uid_and_provider", unique: true, using: :btree

  create_table "co_asientos", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "moneda_id"
    t.decimal  "cotizacion", precision: 10, scale: 2
    t.integer  "empresa_id"
    t.boolean  "esgenerado"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "co_asientos", ["moneda_id"], name: "index_co_asientos_on_moneda_id", using: :btree

  create_table "co_cotizaciones", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "moneda_id"
    t.decimal  "valor",      precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "co_cotizaciones", ["moneda_id"], name: "index_co_cotizaciones_on_moneda_id", using: :btree

  create_table "co_cuentas", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "co_impuestos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.decimal  "alicuota",   precision: 10, scale: 2, default: 0.0
    t.decimal  "coef",       precision: 10, scale: 4, default: 0.0
    t.integer  "c_cta_id"
    t.integer  "d_cta_id"
  end

  create_table "co_items", force: :cascade do |t|
    t.integer  "asiento_id"
    t.date     "venc"
    t.integer  "cuenta_id"
    t.decimal  "debe",            precision: 10, scale: 2, default: 0.0
    t.decimal  "haber",           precision: 10, scale: 2, default: 0.0
    t.string   "organizacion_id"
    t.text     "obs"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "co_items", ["asiento_id"], name: "index_co_items_on_asiento_id", using: :btree

  create_table "co_monedas", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fw_notas", force: :cascade do |t|
    t.string   "titulo"
    t.text     "contenido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "usuario_id"
  end

  create_table "fw_scopes", force: :cascade do |t|
    t.string   "gid"
    t.integer  "objeto_id"
    t.boolean  "publico",    default: false
    t.integer  "incluido",   default: [],                 array: true
    t.integer  "excluido",   default: [],                 array: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "fw_scopes", ["excluido"], name: "index_fw_scopes_on_excluido", using: :gin
  add_index "fw_scopes", ["incluido"], name: "index_fw_scopes_on_incluido", using: :gin

  create_table "fw_tags", force: :cascade do |t|
    t.string   "gid"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "general",    default: [],                 array: true
    t.integer  "objeto_id"
    t.string   "sistema",    default: [],                 array: true
    t.boolean  "publico",    default: false
    t.integer  "incluido",   default: [],                 array: true
    t.integer  "excluido",   default: [],                 array: true
  end

  add_index "fw_tags", ["excluido"], name: "index_fw_tags_on_excluido", using: :gin
  add_index "fw_tags", ["general"], name: "index_fw_tags_on_general", using: :gin
  add_index "fw_tags", ["incluido"], name: "index_fw_tags_on_incluido", using: :gin
  add_index "fw_tags", ["sistema"], name: "index_fw_tags_on_sistema", using: :gin

  create_table "fw_tarjetas", force: :cascade do |t|
    t.string   "titulo"
    t.string   "contenido"
    t.hstore   "formato"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "objeto_gid"
    t.integer  "creada_por"
    t.integer  "dirigida_a", default: [],              array: true
    t.integer  "estado",     default: 1
  end

  create_table "in_depositos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "op_bases", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "organizacion_id"
    t.integer  "empresa_id"
    t.decimal  "bruto",           precision: 10, scale: 2
    t.decimal  "impuesto",        precision: 10, scale: 2
    t.decimal  "total",           precision: 10, scale: 2
    t.text     "obs"
    t.string   "tipo"
    t.integer  "moneda_id"
    t.string   "comprobante"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "asiento_id"
    t.json     "detalle",                                  default: {}, null: false
  end

  create_table "op_condiciones", force: :cascade do |t|
    t.integer  "base_id"
    t.integer  "cuenta_id"
    t.string   "forma"
    t.decimal  "importe",    precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "op_items", force: :cascade do |t|
    t.integer  "base_id"
    t.integer  "producto_id"
    t.string   "saldo_tipo"
    t.text     "obs"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.decimal  "precio",      precision: 10, scale: 2
    t.decimal  "cantidad",    precision: 10, scale: 2, default: 1.0
    t.decimal  "importe",     precision: 10, scale: 2
    t.integer  "impuesto_id"
  end

  add_index "op_items", ["base_id"], name: "index_op_items_on_base_id", using: :btree

end
