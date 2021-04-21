module WebmockHelpers
  def stub_request_response(url, options = {})
    method, body, status, headers = parse_options(options)

    stub_request(method, url)
      .to_return(body: body, status: status, headers: headers)
  end

  private
  def parse_options(options)
    return options.fetch(:method) { :get },

      options.fetch(:body),

      options.fetch(:status) { 200 },

      options.fetch(:headers) do
        {
          'Content-Length' => options[:body].length
        }
      end
  end
end

RSpec.configure do |config|
  config.include WebmockHelpers
end
