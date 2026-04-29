class Admin::Survey::CategoriesController < AdminController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :set_survey, only: [:new, :create, :edit, :update, :destroy]

  def new
    @category = @survey.categories.new
    authorize! @category

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @category = @survey.categories.new(category_params)
    authorize! @category

    respond_to do |format|
      if @category.save
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Category was successfully created." }
      else
        format.turbo_stream { render :new }
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def edit
    authorize! @category

    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    authorize! @category

    respond_to do |format|
      if @category.update(category_params)
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Category was successfully updated." }
      else
        format.turbo_stream { render :edit }
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    authorize! @category

    respond_to do |format|
      if @category.destroy
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "#{@category.name} was successfully destroyed." }
      end
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_category
    @category = Survey::Category.find(params[:id])
  end

  def category_params
    params.require(:survey_category).permit(:name, :position, :survey_id)
  end
end
