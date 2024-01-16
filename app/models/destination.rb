class Destination < ApplicationRecord
  
  geocoded_by :full_address
  after_validation :geocode
  
  # ============= relations ============
  
  has_many :dive_sites
  has_many :dive_centers
  has_many :destination_conditions
  
  # ============= validations ============
  
  validates :country, presence: true
  validates :country_code, presence: true
  
  # ============= scopes ============
  
  # Méthode pour récupérer toutes les villes d'un pays
  def self.cities_in_country(country)
    # Sous-requête pour trouver l'ID minimum pour chaque ville dans le pays
    subquery = Destination.where(country: country)
      .where.not(city: nil)
      .select("MIN(id) as id")
      .group(:city)

    # Utiliser la sous-requête pour obtenir les objets Destination
    Destination.where(id: subquery)
  end

  # Méthode pour récupérer toutes les régions d'un pays
  def self.regions_in_country(country)
    # Sous-requête pour trouver l'ID minimum pour chaque combinaison unique de pays et de région
    subquery = Destination.where(country: country)
      .where.not(region: nil)
      .where(city: nil)
      .select("MIN(id) as id")
      .group(:region)

    # Utiliser la sous-requête pour obtenir les objets Destination
    Destination.where(id: subquery)
  end

  # Méthode pour récupérer toutes les villes d'une région
  def self.cities_in_region(country, region)
    # Sous-requête pour trouver l'ID minimum pour chaque ville dans la région
    subquery = Destination.where(country: country, region: region)
      .where.not(city: nil)
      .select("MIN(id) as id")
      .group(:city)

    # Utiliser la sous-requête pour obtenir les objets Destination
    Destination.where(id: subquery)
  end
  
  # ============= methods ===========
  
  def name
    if city
      return city
    elsif city.blank? && region
      return region
    else
      return country
    end
  end
  
  def full_address
    [city, region, country].compact.join(', ')
  end
  
end
