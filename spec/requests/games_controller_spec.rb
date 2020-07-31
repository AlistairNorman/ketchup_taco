require 'rails_helper'

RSpec.describe "GamesController", type: :request do
  describe "GET #new" do
    subject { get "/games/#{game_id}" }

    let(:game_id) { 2017020001 }

    it { is_expected.to render_template :show }
  end
end
