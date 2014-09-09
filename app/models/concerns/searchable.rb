module Searchable
  extend ActiveSupport::Concern

  included do

    before_save :update_name_encoded

    private 

    def update_name_encoded
      self.name_encoded = encode(self.name)
    end
  end

  # methods defined here are going to extend the class, not the instance of it
  module ClassMethods

    def search name
      return self.where(:name_encoded => encode(name)) if name.is_a? String
      return self.where(:name_encoded => encode(name.first)) if name.is_a? Array

      puts "Usage: #{self.name}.search(<name>)"
      return nil
    end

    def search_by_province (*args)

      if args[0].is_a?(String) and args[1].is_a?(Integer)

        if self == Point

          points = self.where(:name_encoded => encode(args[0]))
          l = []
          points.each do |point|

            if point.pointable.is_a? Pass

              point.pointable.localities.each do |locality|

                if locality.is_a? Fraction
                  if locality.municipality.province_id == args[1]
                    l << point 
                    break
                  end

                else #point.pointable.is_a? Municipality
                  if locality.province_id == args[1]
                    l << point 
                    break
                  end
                end #end if

              end # end localities loop

            elsif point.pointable.is_a? Fraction 

              l << point if point.pointable.municipality.province_id == args[1]

            else #point.pointable.is_a? Municipality

              l << point if point.pointable.province_id == args[1]
              
            end

          end # end points loop
          return l

        elsif self == Pass 

          passes = self.where(name_encoded: encode(args[0]))
          l = []
          
          passes.each do |pass|
            pass.localities.each do |locality|

              if locality.localitiable.is_a? Fraction

                if locality.localitiable.municipality.province_id == args[1]
                  l << pass 
                  break
                end

              else #locality.localitiable.is_a? Municipality

                if locality.localitiable.province_id == args[1]
                  l << pass 
                  break
                end
              end #end if

            end # end localities loop
          end
          return l

        elsif self == Fraction 

          fractions = self.where(name_encoded: encode(args[0]))
          s = []
          fractions.each do |f|
            s << f if f.municipality.province_id == args[1]
          end
          return s

        else # self == Municipality
          return self.where(name_encoded: encode(args[0]), province_id: args[1])
        end

      end
      
      puts "Usage: #{self.name}.search(<name>,<region_id>)"
      return nil

    end

    def search_by_region (*args)

      if args[0].is_a?(String) and args[1].is_a?(Integer)

        if self == Point

          points = self.where(:name_encoded => encode(args[0]))
          l = []
          points.each do |point|
            if point.pointable.is_a?(Pass)
              point.pointable.localities.each do |locality|
                l << point if locality.localitiable.region_id == args[1]
                break
              end
            else
              l << point if point.pointable.region_id == args[1]
            end
          end
          return l

        elsif self == Pass
          
          l = []
          passes = self.where(name_encoded: encode(args[0]))
          passes.each do |pass|
            pass.localitiables.each do |locality|
              if locality.region_id == args[1]
                l << pass 
                break
              end
            end
          end
          return l

        else
          return self.where(name_encoded: encode(args[0]), region_id: args[1])
        end

      end

      puts "Usage: #{self.name}.search(<name>,<region_id>)"
      return nil
    end

    def search_by_regions name, regions

      points = []
      regions.each do |region|
        points.concat(self.search_by_region(name, region.id))
      end
      return points
    end

  end # modulo
end

def encode name
  name = name.downcase
  name = name.split("/").first if name.match(/\//)
  name = name.split("\\").first if name.match(/\\/)
  name = name.split(" - ").first if name.match(/ - /)

  while name != encode1(name) do
    name = encode1(name)
  end
  # only at the end remove spaces
  name = name.gsub(/[^0-9A-Za-z]/, '')
  return name
end

def encode1 name
  # parole e congiunzioni preceduti e seguiti da uno spazio o all inizio della riga
  name = name.gsub(/(^|\s|-)(e|a|al|d|di|de|del|dell|dello|delle|della|degli|da|dal|dall|dalla|dallo|dei|du|san|sant|sant[o|a|i])[-]?\s/, ' ') 
  name = name.gsub(/(^|\s|-)(d|du|del|dal|dell|dall|san|sant)['-]\s?/,' ') # il ? sta per 0 o 1
  name = name.gsub(/(^|\s)s\./,' ')
  return name
end

# questa è quella vecchia just to know
# def encode name
#   name = name.downcase
#   name = name.split("/").first if name.match(/\//)
#   name = name.split("\\").first if name.match(/\\/)
#   name = name.split(" - ").first if name.match(/ - /)
#   name = name.gsub(/\s(e|del|dello|di|delle|dell|de|d|da|dal|della|dei|du|san|sant|sant[o|a|i])\s/, '')
#   name = name.gsub(/s\.\s*/,'')
#   name = name.gsub(/(d|dell|dall|sant)['-]\s*/,'')
#   name = name.gsub(/[^0-9A-Za-z]/, '')
#   return name
# end