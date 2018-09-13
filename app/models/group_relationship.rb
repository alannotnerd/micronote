class GroupRelationship < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  before_destroy :clean_up
  def GroupRelationship.clean
    all = GroupRelationship.all
    all.each do |gr|
      _grs = GroupRelationship.where(user_id: gr.user_id, group_id: gr.group_id)
      _gr_main = _grs[0]
      _grs.each do |_gr|
        _gr.destroy unless _gr.id == _gr_main.id
      end
    end
  end

  def clean_up
    GroupRelationshopCleanupJob.perform_now self
  end
end
