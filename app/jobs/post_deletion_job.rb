class PostDeletionJob < ApplicationJob
#   queue_as :default

  def perform(*args)
    # Do something later
    print("heeeeeeeeeh")
  end
end
