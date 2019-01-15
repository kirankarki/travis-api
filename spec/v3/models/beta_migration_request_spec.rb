require 'spec_helper'

describe Travis::API::V3::Models::BetaMigrationRequest do
  let(:subject) { Factory.build(:beta_migration_request) }

  # context "without authentication" do
  #   before { post("/v3/user/#{subject.owner.id}/beta_migration_request") }
  #   include_examples 'not authenticated'
  # end

  context "with authentication" do
  #   let!(:token) { Travis::Api::App::AccessToken.create(user: subject.owner, app_id: 1) }
  #   let!(:headers) {{ 'HTTP_AUTHORIZATION' => "token #{token}" }}

  #   before  { post("/v3/user/#{subject.owner.id}/beta_migration_request", {}, headers)      }

    it "should enable beta for owner after save" do
      subject.save!
      expect(Travis::Features.owner_active?(:beta_migration_opt_in, subject.owner)).to be true
    end

    it "should enable beta for all valid orgs selected" do
      subject.save!
      valid_orgs = [Factory(:membership, user_id: subject.owner.id, role: "admin"), Factory(:membership, user_id: subject.owner.id, role: "admin")]
      valid_orgs.each do |org|
        expect(Travis::Features.owner_active?(:beta_migration_opt_in, org)).to be true
      end
    end
  end
end
