class BaseRepository
  def initialize(gateway:)
    @gateway = gateway
  end

  def insert!(params = {})
    gateway.create!(params)
  end

  def find(id)
    gateway.find(id)
  end

  def count
    gateway.count
  end

  private

  attr_reader :gateway
end
