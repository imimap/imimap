require "rails_helper"

RSpec.describe ReadsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/reads").to route_to("reads#index")
    end

    it "routes to #new" do
      expect(:get => "/reads/new").to route_to("reads#new")
    end

    it "routes to #show" do
      expect(:get => "/reads/1").to route_to("reads#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reads/1/edit").to route_to("reads#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/reads").to route_to("reads#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reads/1").to route_to("reads#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reads/1").to route_to("reads#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reads/1").to route_to("reads#destroy", :id => "1")
    end

  end
end
