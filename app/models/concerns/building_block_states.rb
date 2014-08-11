module BuildingBlockStates
  extend ActiveSupport::Concern

  included do
    include Workflow

    workflow do
      state :draft do
        event :submit, transitions_to: :awaiting_review
      end

      state :awaiting_review do
        event :reviewing, transitions_to: :under_review
      end

      state :under_review do
        event :accept, transitions_to: :accepted
        event :reject, transitions_to: :rejected
      end

      state :accepted do
        # send email to owner
      end
      state :rejected do
        # send email to owner
      end
    end
  end
end
