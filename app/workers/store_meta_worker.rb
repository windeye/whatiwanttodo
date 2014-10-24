class StoreMetaWorker
  include Sidekiq::Worker
  sidekiq_options queue: :pages

  def perform(slide_id)
    s = Powerpoint.find_by_id(slide_id)
    p = s.pdffile.path
    #是否要catch异常
    reader = PDF::Reader.new(p)
    s.update_column(:page_count, reader.page_count)
  end
end
