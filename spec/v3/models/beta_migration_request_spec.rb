describe Travis::API::V3::Models::BetaMigrationRequest do
  let(:subject) { Factory.build(:beta_migration_request) }


  it "should enable beta for owner after save" do
    subject
    # check flag
  end

  it "creates a beta_migration_request record" do
    before  { post("/beta_migration_request")      }
    example { expect(last_response.status).to be == 200 }
    example { expect(JSON.load(body)).to      be ==     {
      "@type"         => "error",
      "error_type"    => "login_required",
      "error_message" => "login required"
        }}
  end
end
