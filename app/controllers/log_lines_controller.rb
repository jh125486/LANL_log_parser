class LogLinesController < ApplicationController
  before_action :set_node
  before_action :set_log_lines
  before_action :set_log_line, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js, :datatable

  def index
    respond_with @log_lines do |format|
      format.datatable do
        render json: LogLinesDatatable.new(view_context, collection: @log_lines)
      end
    end
  end

  def show
    respond_with @node, @log_line
  end

  def new
    @log_line = LogLine.new
    add_breadcrumb :new, new_node_log_line_path(@node, @log_line)
    respond_with @node, @log_line
  end

  def edit
    add_breadcrumb :edit, edit_node_log_line_path(@node, @log_line)
  end

  def create
    @log_line = LogLine.new log_line_params
    @log_line.save
    respond_with @node, @log_line
  end

  def update
    @log_line.update log_line_params
    respond_with @node, @log_line
  end

  def destroy
    @log_line.destroy
    respond_with @node, @log_line
  end

  private

  def xeditable?(obj)
    true
  end
  helper_method :xeditable?

  def set_node
    @node = Node.find params[:node_id]
    add_breadcrumb 'Nodes', :nodes_path
    add_breadcrumb @node, node_path(@node)
  end

  def set_log_lines
    @log_lines = @node.log_lines
    add_breadcrumb :index, node_log_lines_path(@node)
  end

  def set_log_line
    @log_line = @log_lines.find params[:id]
    add_breadcrumb @log_line, @log_line
  end

  def log_line_params
    permitted = %i(comment priority)
    permitted << { info: %i(process pid) }
    params.require(:log_line).permit permitted
  end
end
