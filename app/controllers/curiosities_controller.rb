class CuriositiesController< ApplicationController

  def show
  	@curiosity = Curiosity.find(params[:id])
  end

  def destroy
    @curiosity = Curiosity.find(params[:id]) # Récupère l'identifiant de la curiosité à supprimer
	  @curiosity.delete                        # Supprime la curiosité dans la base de données

	  redirect_to home_index_path    # Redirige l'utilisateur vers la vue Index
  end

  def new
	@curiosity = Curiosity.new # Crée une curiosité 'vide'
  end

  def create
    @curiosity = Curiosity.new(curiosity_params)
    # instance une nouvelle curiosité
    # avec les parametres contenus dans le formulaire
    # et passés à la variable params

    if @curiosity.save # Si la curiosité est sauvegardée sans erreurs
      redirect_to @curiosity # alors on l'affiche
    else
      render 'new' # sinon on reste sur la page de création
    end
  end

  private

  def curiosity_params
    params.require(:curiosity).permit(:name, :description, :image_url, :image_text)
  end

end