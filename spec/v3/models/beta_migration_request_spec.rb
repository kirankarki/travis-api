require 'spec_helper'

describe Travis::API::V3::Models::BetaMigrationRequest do
  let(:subject) { Factory.build(:beta_migration_request) }

  context "without authentication" do
    before { post("/v3/user/#{subject.owner.id}/beta_migration_request") }
    include_examples 'not authenticated'
  end

  context "with authentication" do
    let!(:token) { Travis::Api::App::AccessToken.create(user: subject.owner, app_id: 1) }
    let!(:headers) {{ 'HTTP_AUTHORIZATION' => "token #{token}" }}

    before  { post("/v3/user/#{subject.owner.id}/beta_migration_request", {}, headers)      }

    it "should enable beta for owner after save" do
      subject.save!
      expect(Travis::Features.owner_active?(:allow_migration, subject.owner)).to be true
    end
  end
end
