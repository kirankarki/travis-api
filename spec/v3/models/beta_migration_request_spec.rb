require 'spec_helper'

describe Travis::API::V3::Models::BetaMigrationRequest do
  let(:subject) { Factory(:beta_migration_request) }

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
