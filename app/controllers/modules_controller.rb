class ModulesController < ApplicationController
  def metronome
    render layout: false
  end

  def drone
    render layout: false
  end

  def students
    @contacts = current_user.contacts
    @assignments = current_user.get_recent_assignments
    @pending = current_user.get_pending_assignments
    render layout: false
  end

end