class PowerGeneratorSearch
  def self.simple_search(search, order)
    PowerGenerator.name_description_search(search)
                  .order_search(order)
  end

  def self.advanced_search(params)
    generators = PowerGenerator.all

    if params[:manufacturer].present?
      generators = generators.where(manufacturer: params[:manufacturer])
    end

    if params[:structure_type].present?
      generators = generators.where(structure_type: params[:structure_type])
    end

    if params[:price_min].present? || params[:price_max].present?
      generators = generators.ranged_sql_where('price',
                                               params[:price_min],
                                               params[:price_max])
    end

    if params[:kwp_min].present? || params[:kwp_max].present?
      generators = generators.ranged_sql_where('kwp',
                                               params[:kwp_min],
                                               params[:kwp_max])
    end

    if params[:height_min].present? || params[:height_max].present?
      generators = generators.ranged_sql_where('height',
                                               params[:height_min],
                                               params[:height_max])
    end

    if params[:width_min].present? || params[:width_max].present?
      generators = generators.ranged_sql_where('width',
                                               params[:width_min],
                                               params[:width_max])
    end

    if params[:lenght_min].present? || params[:lenght_max].present?
      generators = generators.ranged_sql_where('lenght',
                                               params[:lenght_min],
                                               params[:lenght_max])
    end

    if params[:weight_min].present? || params[:weight_max].present?
      generators = generators.ranged_sql_where('weight',
                                               params[:weight_min],
                                               params[:weight_max])
    end

    generators
  end
end
