module Travis::API::V3
  class Models::BetaMigrationRequest < Model
    belongs_to :owner, polymorphic: true
    after_save :enable_beta

    def enable_beta
      # set flag for user
    end
  end
end
