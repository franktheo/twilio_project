class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    #to = params[:number_to_send_to]
    to = "14084839243"

    #live credentials
    #message = client.account.messages.create from: '16503860742', to: '14084839243', body: 'SMS message from Frank.'

    #test credentials
    message = client.account.messages.create from: '+15005550006', to: to, body: 'Learning to send SMS you are.'
    logger.info("TP notify")
    logger.info("TP message: #{message.inspect}")
    #logger.info("TP message: #{message.class_variables.inspect}")
    logger.info("TP message class: #{message.class.inspect}")

    logger.info("TP message variable path: #{message.instance_variable_get(:@path)}")

    #logger.info("TP message superclass: #{message.superclass.inspect}")

    #message = client.account.messages.create from: '16503860742', to: '14084839243', body: 'Learning to send SMS you are.', media_url: 'http://linode.rabasa.com/yoda.gif', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end
 
  def status
    # the status can be found in params['MessageStatus']

    # send back an empty response
    render_twiml Twilio::TwiML::Response.new
  end

end
