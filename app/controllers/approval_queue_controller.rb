module Api
  class ApprovalQueueController < ApplicationController
    def index
      @approval_queue = Approval.all.order(request_date: :asc)
      render json: @approval_queue
    end

    def approve
      approval = Approval.find(params[:approval_id])
      approval.product.update(status: 'active')
      approval.destroy
      render json: { message: 'Product approved successfully.' }
    end

    def reject
      approval = Approval.find(params[:approval_id])
      approval.product.update(status: 'rejected')
      approval.destroy
      render json: { message: 'Product rejected successfully.' }
    end
  end
end