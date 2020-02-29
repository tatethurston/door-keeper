class TwilioController < ActionController::API
  def index
    render xml: <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <Response>
        <Gather numDigits="4" timeout="10" action="#{access_twilio_index_path}">
          <Say>Please enter your 4 digit code, followed by the pound sign.</Say>
        </Gather>
        <Say>I didn't receive any input. Please try again.</Say>
        <Play digits="w*"/>
      </Response>
    XML
  end

  def access
    value = params[:Digits]
    phone_number = params[:To]

    door = Door.find_by(phone_number: phone_number)
    if door.nil?
      render json: { error: ["Not Found"] }, status: :not_found
      return
    end

    log = DoorKeeperService.open(door: door, value: value)

    render xml:
      if log.success
        <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <Response>
            <Say>Thanks. I'm buzzing you in now.</Say>
            <Play digits="w9"/>
          </Response>
        XML
      else
        if log.denied_reason == DoorKeeperService::CODE_UNKNOWN
          <<~XML
            <?xml version="1.0" encoding="UTF-8"?>
            <Response>
              <Say>Sorry, I don't recognize that code. Please try again.</Say>
              <Play digits="w*"/>
            </Response>
          XML
        else
          <<~XML
            <?xml version="1.0" encoding="UTF-8"?>
            <Response>
              <Say>That code is not authorized for this door at this time.</Say>
              <Play digits="w*"/>
            </Response>
          XML
        end
      end
  end
end
