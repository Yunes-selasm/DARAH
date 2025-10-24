
module View::V1
  class HubspotActionsController < ApplicationController
    before_action :find_action, only: :show

    # GET /view/v1/hubspot_actions/:id
    def show; end

    # GET /view/v1/hubspot_actions/
    def index
      @q = HubspotAction.ransack(params[:q])
      @actions = @q.result.page(params[:page]).per(10)
      @actions = @actions.order(updated_at: :desc)
    end

    private

    def find_action
      @action = HubspotAction.find(params[:id])
    end
    
  end
end

