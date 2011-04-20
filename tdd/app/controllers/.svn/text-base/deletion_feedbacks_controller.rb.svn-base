class DeletionFeedbacksController < ApplicationController
  # GET /deletion_feedbacks
  # GET /deletion_feedbacks.xml
  def index
    @deletion_feedbacks = DeletionFeedback.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deletion_feedbacks }
    end
  end

  # GET /deletion_feedbacks/1
  # GET /deletion_feedbacks/1.xml
  def show
    @deletion_feedback = DeletionFeedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deletion_feedback }
    end
  end

  # GET /deletion_feedbacks/new
  # GET /deletion_feedbacks/new.xml
  def new
    @deletion_feedback = DeletionFeedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deletion_feedback }
    end
  end

  # GET /deletion_feedbacks/1/edit
  def edit
    @deletion_feedback = DeletionFeedback.find(params[:id])
  end

  # POST /deletion_feedbacks
  # POST /deletion_feedbacks.xml
  def create
    @deletion_feedback = DeletionFeedback.new(params[:deletion_feedback])

    respond_to do |format|
      if @deletion_feedback.save
        format.html { redirect_to(@deletion_feedback, :notice => 'Deletion feedback was successfully created.') }
        format.xml  { render :xml => @deletion_feedback, :status => :created, :location => @deletion_feedback }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deletion_feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deletion_feedbacks/1
  # PUT /deletion_feedbacks/1.xml
  def update
    @deletion_feedback = DeletionFeedback.find(params[:id])

    respond_to do |format|
      if @deletion_feedback.update_attributes(params[:deletion_feedback])
        format.html { redirect_to(@deletion_feedback, :notice => 'Deletion feedback was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deletion_feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deletion_feedbacks/1
  # DELETE /deletion_feedbacks/1.xml
  def destroy
    @deletion_feedback = DeletionFeedback.find(params[:id])
    @deletion_feedback.destroy

    respond_to do |format|
      format.html { redirect_to(deletion_feedbacks_url) }
      format.xml  { head :ok }
    end
  end
end
