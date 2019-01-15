module Travis::API::V3
  class Models::BetaMigrationRequest < Model
    belongs_to    :owner, polymorphic: true
    has_many      :organizations

    after_save    :enable_beta

    def enable_beta
      ([owner]).map do |o|
        Travis::Features.activate_owner(:beta_migration_opt_in, o)
      end
    end
  end
end
