class PostDeletionWorker 
  include Sidekiq::Worker
  # sidekiq_options :backtrace => 5

  def perform(id)
    print("idddddddddddddddddddddddddddddddddddddddddddddddddddd" , id)
    Post.find(id).delete
  end
end
