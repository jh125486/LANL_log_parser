class NodesController < ApplicationController
  before_action :set_nodes
  before_action :set_node, only: [:show, :edit, :update, :destroy]
  INCLUDES = %i()

  respond_to :html, :js, :datatable

  def index
    respond_with @nodes do |format|
      format.datatable do
        render json: NodesDatatable.new(view_context, collection: @nodes)
      end
    end
  end

  def show
    respond_with @node
  end

  def new
    @node = Node.new
    add_breadcrumb :new
    respond_with @node
  end

  def edit
    add_breadcrumb :edit
  end

  def create
    @node = Node.new node_params
    @node.save
    respond_with(@node)
  end

  def update
    @node.update node_params
    respond_with @node
  end

  def destroy
    @node.destroy
    respond_with @node
  end

  private

  def set_nodes
    @nodes = Node.includes(INCLUDES).references(INCLUDES)
    add_breadcrumb :index, :nodes_path
  end

  def set_node
    @node = @nodes.find params[:id]
    add_breadcrumb @node, @node
  end

  def node_params
    permitted = %i(comment priority)
    params.require(:node).permit permitted
  end
end
