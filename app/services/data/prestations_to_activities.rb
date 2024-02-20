class Data::PrestationsToActivities
  
  CORRESPONDANCES = {
    scubadiving: "Scuba diving",
    xr: "Tek diving",
    freediving: "Freediving",
    snorkeling: "Snorkeling",
    horizon: "Rebreather",
    mares_lab: "Mares lab",
    spearfishing: "Spearfishing",
    dc: "Dive Center"
  }
  
  def perform
    dive_centers = DiveCenter.all
    counter = 0
    no_prestation_counter = 0
    max = dive_centers.size
    
    dive_centers.each do |dive_center|
      if dive_center.prestations.present?
        dive_center.prestations.each do |prestation|
          activity = Activity.find_or_create_by(name: CORRESPONDANCES[prestation.to_sym])
          dive_center.activities << activity
        end
        counter += 1
        puts "Updater #{counter}/#{max}"
      else
        puts "No prestations for DiveCenter ##{dive_center.id} - #{dive_center.name} - #{dive_center.web_url}."
        no_prestation_counter += 1
      end
    end
    
    puts "FINISH -> #{counter} updated. #{no_prestation_counter} centers did not have any prestation"
  end
end
