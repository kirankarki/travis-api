require 'spec_helper'

describe Travis::API::V3::Models::BetaMigrationRequest do
  let(:subject) { Factory(:beta_migration_request) }

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
      orgs = [Factory(:org_v3), Factory(:org_v3)]
      orgs.each do |org|
        org.memberships << Factory(:membership, user_id: subject.owner.id, role: "admin")
        subject.organizations << org
        org.beta_migration_request_id = subject.id
        org.save!
        subject.save!
      end

      subject.organizations.each do |org|
        expect(Travis::Features.owner_active?(:beta_migration_opt_in, org)).to be true
      end
    end
  end
end
