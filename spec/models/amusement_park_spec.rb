require "rails_helper"

RSpec.describe AmusementPark, type: :model do
  let!(:mech_1) { Mechanic.create!(name: "Buddy", years_experience: 18) }
  let!(:mech_2) { Mechanic.create!(name: "Ralph", years_experience: 26) }
  let!(:mech_3) { Mechanic.create!(name: "Xtina", years_experience: 12) }
  
  let!(:cedar) { AmusementPark.create!(name: "Cedar Point", admission_cost: 50) }
  let!(:elitch) { AmusementPark.create!(name: "Elitch Gardens", admission_cost: 55) }

  let!(:log) { cedar.rides.create!(name: "Log Jammin'", thrill_rating: 6, open: true) }
  let!(:mant) { cedar.rides.create!(name: "The Mantis", thrill_rating: 9, open: true) }
  let!(:holy) { cedar.rides.create!(name: "Holy Roller", thrill_rating: 10, open: false) }
  let!(:me) { elitch.rides.create!(name: "Mind Eraser", thrill_rating: 9, open: true) }

  let!(:ride_mech_1) { RideMechanic.create!(mechanic_id: mech_1.id, ride_id: log.id) }
  let!(:ride_mech_2) { RideMechanic.create!(mechanic_id: mech_1.id, ride_id: mant.id) }
  let!(:ride_mech_3) { RideMechanic.create!(mechanic_id: mech_2.id, ride_id: holy.id) }
  let!(:ride_mech_4) { RideMechanic.create!(mechanic_id: mech_2.id, ride_id: mant.id) }
  let!(:ride_mech_5) { RideMechanic.create!(mechanic_id: mech_3.id, ride_id: me.id) }

  describe "relationships" do
    it { should have_many(:rides) }
    it { should have_many(:mechanics).through(:rides) }
  end

  describe "instance methods" do
    it "#distinct_mechanics" do
      expect(cedar.distinct_mechanics).to eq([mech_1, mech_2])
      expect(elitch.distinct_mechanics).to eq([mech_3])
    end
  end
end