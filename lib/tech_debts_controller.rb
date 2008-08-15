class TechDebtsController < ApplicationController
  layout nil

  # GET /tech_debts
  # GET /tech_debts.xml
  def index
    # Filter conditions
    scope = TechDebt.scoped({})
    scope = scope.td_conditions "tech_debts.keywords LIKE ?", "%#{params[:keyword]}%" unless params[:keyword].nil? or params[:keyword] == "-"
    scope = scope.td_conditions "tech_debts.created_at > ?", params[:newer_than].to_i.days.ago.to_s(:db) unless params[:newer_than].nil? or params[:newer_than] == "-"
    scope = scope.td_conditions "tech_debts.created_at < ?", params[:older_than].to_i.days.ago.to_s(:db) unless params[:older_than].nil? or params[:older_than] == "-"
    scope = scope.td_conditions "tech_debts.priority >= ?", params[:priority] unless params[:priority].nil? or params[:priority] == "-"

    @current_filter = {:keyword => params[:keyword],
                       :newer_than => params[:newer_than],
                       :older_than => params[:older_than],
                       :priority => params[:priority]}
    @tech_debts = scope.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tech_debts }
    end
  end

  # GET /tech_debts/1
  # GET /tech_debts/1.xml
  def show
    @tech_debt = TechDebt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tech_debt }
    end
  end

  # GET /tech_debts/new
  # GET /tech_debts/new.xml
  def new
    @tech_debt = TechDebt.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tech_debt }
    end
  end

  # GET /tech_debts/1/edit
  def edit
    @tech_debt = TechDebt.find(params[:id])
  end

  # POST /tech_debts
  # POST /tech_debts.xml
  def create
    @tech_debt = TechDebt.new(params[:tech_debt])

    respond_to do |format|
      if @tech_debt.save
        flash[:notice] = 'TechDebt was successfully created.'
        format.html { redirect_to(@tech_debt) }
        format.xml  { render :xml => @tech_debt, :status => :created, :location => @tech_debt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tech_debt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tech_debts/1
  # PUT /tech_debts/1.xml
  def update
    @tech_debt = TechDebt.find(params[:id])

    respond_to do |format|
      if @tech_debt.update_attributes(params[:tech_debt])
        flash[:notice] = 'TechDebt was successfully updated.'
        format.html { redirect_to(@tech_debt) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tech_debt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tech_debts/1
  # DELETE /tech_debts/1.xml
  def destroy
    @tech_debt = TechDebt.find(params[:id])
    @tech_debt.destroy

    respond_to do |format|
      format.html { redirect_to(tech_debts_url) }
      format.xml  { head :ok }
    end
  end
end
