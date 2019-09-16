class LineMessagingService
  def broadcast(text)
    message = {
      type: 'text',
      text: text
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = Settings.line_messaging_api.channel_secret
        config.channel_token = Settings.line_messaging_api.channel_token
    }
    client.broadcast(message)
  end
end
