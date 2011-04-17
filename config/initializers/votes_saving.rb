# ActsAsVoteable
module Juixe
  module Acts #:nodoc:
    module Voteable #:nodoc:

      # This module contains instance methods
      module InstanceMethods
        def votes_for
          Vote.count(:all, :conditions => [
              "voteable_id = ? AND voteable_type = ? AND vote = ?",
              id, self.class.base_class.name, true
            ])
        end

        def votes_against
          Vote.count(:all, :conditions => [
              "voteable_id = ? AND voteable_type = ? AND vote = ?",
              id, self.class.base_class.name, false
            ])
        end


        def voted_by?(voter)
          rtn = false
          if voter
            self.votes.each { |v|
              rtn = true if (voter.id == v.voter_id && voter.class.base_class.name == v.voter_type)
            }
          end
          rtn
        end

      end
    end
  end
end


# ActsAsVoter
module PeteOnRails
  module Acts #:nodoc:
    module Voter #:nodoc:


      # This module contains instance methods
      module InstanceMethods

        # Usage user.vote_count(true)  # All +1 votes
        #       user.vote_count(false) # All -1 votes
        #       user.vote_count()      # All votes

        def vote_count(for_or_against = "all")
          where = (for_or_against == "all") ?
            ["voter_id = ? AND voter_type = ?", id, self.class.base_class.name ] :
            ["voter_id = ? AND voter_type = ? AND vote = ?", id, self.class.base_class.name, for_or_against ]

          Vote.count(:all, :conditions => where)

        end

        def voted_for?(voteable)
          0 < Vote.count(:all, :conditions => [
              "voter_id = ? AND voter_type = ? AND vote = TRUE AND voteable_id = ? AND voteable_type = ?",
              self.id, self.class.base_class.name, voteable.id, voteable.class.base_class.name
            ])
        end

        def voted_against?(voteable)
          0 < Vote.count(:all, :conditions => [
              "voter_id = ? AND voter_type = ? AND vote = FALSE AND voteable_id = ? AND voteable_type = ?",
              self.id, self.class.base_class.name, voteable.id, voteable.class.base_class.name
            ])
        end

        def voted_on?(voteable)
          0 < Vote.count(:all, :conditions => [
              "voter_id = ? AND voter_type = ? AND voteable_id = ? AND voteable_type = ?",
              self.id, self.class.base_class.name, voteable.id, voteable.class.base_class.name
            ])
        end
      end
    end
  end
end