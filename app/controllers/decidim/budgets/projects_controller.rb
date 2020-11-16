# frozen_string_literal: true

module Decidim
  module Budgets
    # Exposes the project resource so users can view them
    class ProjectsController < Decidim::Budgets::ApplicationController
      include FilterResource
      include NeedsCurrentOrder
      include Orderable

      helper_method :projects, :project, :geocoded_projects

      private

      def projects
        @projects ||= search.results.page(params[:page]).per(current_component.settings.projects_per_page)
      end

      def project
        @project ||= search.results.find(params[:id])
      end

      def search_klass
        ProjectSearch
      end

      def default_filter_params
        {
          search_text: "",
          scope_id: "",
          category_id: ""
        }
      end

      def context_params
        { component: current_component, organization: current_organization }
      end

      def geocoded_projects
        @geocoded_projects ||= search.results.select(&:geocoded?)
      end
    end
  end
end
