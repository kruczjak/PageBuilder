class RouteHelper
  class << self
    def actions(described_class)
      routes.select { |r| r.defaults[:controller] == controller(described_class) }.map { |r| new(r) }
    end

    def routes
      Rails.application.routes.routes
    end

    def controller(described_class)
      described_class.name.underscore.gsub(/_controller\z/, '')
    end
  end

  def initialize(route)
    @route = route
  end

  def verb
    @route.verb.to_s.match(/[A-Z]+/)[0].downcase
  end

  def action
    @route.defaults[:action]
  end

  def required_params
    rp = @route.required_parts
    values = [0] * rp.size
    Hash[rp.zip(values)]
  end
end

shared_examples 'it requires authenticated user' do
  RouteHelper.actions(described_class).each do |route|
    it "returns 401 for action #{route.action}" do
      send(route.verb, route.action, params: route.required_params)
      expect(response.status).to eq(401)
    end
  end

  context 'when authenticated' do
    before do
      authenticate_user(FactoryGirl.create(:user))
    end

    RouteHelper.actions(described_class).each do |route|
      it "doesn't returns 401 for action #{route.action}" do
        begin
          send(route.verb, route.action, params: route.required_params)
        rescue Exception
          p 'Exception'
        end

        expect(response.status).not_to eq(401)
      end
    end
  end
end
