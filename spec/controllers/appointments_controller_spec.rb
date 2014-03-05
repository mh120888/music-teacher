require 'spec_helper'

describe AppointmentsController do
  let!(:user) { FactoryGirl.create(:user) }
  before(:each) do
    stub_login user
  end

  context "#index" do
    before(:each) do
      get :index
    end

    it "should be ok" do
      expect(response).to be_ok
    end

    it "should assign appointment and date" do
      expect(assigns(:appointment).class).to eq Appointment
      expect(assigns(:date)).to eq Date.today
    end

    it "should assign appointments_by_date" do
      expect(assigns(:appointments_by_date).class).to eq ActiveSupport::HashWithIndifferentAccess
    end
  end

  context "#create" do
    let(:apt_attrs) { FactoryGirl.attributes_for(:appointment) }

    it "should create a new appointment" do
      expect {
        post :create, appointment: apt_attrs
      }.to change { Appointment.count }.by(1)
    end
  end

  context "#update" do
    let(:apt)      { FactoryGirl.create(:appointment) }
    let(:apt_attr) { FactoryGirl.attributes_for(:appointment) }

    it "should update attributes" do
      expect {
        put :update, {id: apt.id, appointment: apt_attr}
      }.to change { apt.reload.title }
    end
  end

  context "#Destroy" do
    let!(:apt) { FactoryGirl.create(:appointment) }

    it "should destroy an appointment" do
      expect {
        delete :destroy, id: apt.id
      }.to change { Appointment.count }.by(-1)
    end
  end
end