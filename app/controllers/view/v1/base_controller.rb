# frozen_string_literal: true

module View::V1
  class BaseController < ApplicationController
    before_action :find_resource, only: %i[edit update destroy]

    # GET /admin/resources
    def index
      @q = resource_class.includes(includes).ransack(params[:q])
      @q.sorts = 'id asc' if @q.sorts.empty?
      @pagy, @resources = pagy(@q.result(distinct: true), items: 10)
    end

    # GET /admin/resources/new
    def new
      instance_variable_set('@resource', resource_class.new)
    end

    # GET /admin/resources/1/edit
    def edit; end

    # POST /admin/resources
    def create
      @resource = resource_class.new(resource_params)
      if @resource.save
        redirect_to(send(list_path), notice: created_message)
      else
        render(:new)
      end
    end

    # PATCH/PUT /admin/resources/1
    def update
      if @resource.update(resource_params)
        redirect_to(send(list_path), notice: update_message)
      else
        render(:edit)
      end
    end

    # DELETE /admin/resources/1
    def destroy
      @resource.destroy
      redirect_to(send(list_path), notice: destroy_message)
    end

    private

    def find_resource
      @resource = resource_class.find(params[:id])
    end

    def resource_name
      @resource_name ||= controller_name.singularize
    end

    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    def resource_instance
      instance_variable_set(resource_name.to_s)
    end

    def list_path
      "admin_#{pluralize_resource}_path"
    end

    def pluralize_resource
      @pluralize_resource ||= resource_name.pluralize
    end

    def resource_params
      @resource_params ||= send("#{resource_name}_params")
    end

    def created_message
      'Created successfully'
    end

    def update_message
      'Updated successfully'
    end

    def destroy_message
      'Deleted successfully'
    end

    def includes
      []
    end
  end
end
