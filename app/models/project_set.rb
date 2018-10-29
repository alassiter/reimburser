class ProjectSet
  attr_accessor :projects

  def initialize(*projects)
    @projects = projects
  end

  def reimbursement
    projects.sum(&:reimbursement)
  end
end

# TODO: a set needs to take a collection of projects,
# and have its own start and end dates
