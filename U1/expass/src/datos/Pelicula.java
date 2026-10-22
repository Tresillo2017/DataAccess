package datos;

public class Pelicula {

    private int idPelicula;
    private String titulo;
    private String sinopsis;
    private String fechaEstreno;
    private int duracionMin;
    private String idiomaOriginal;
    private String clasificacionEdad;
    private double presupuesto;
    private double recaudacion;
    private int idGeneroPrincipal;
    private Integer idGeneroSecundario;
    private Integer idPeliculaSecuela;

    public Pelicula(int idPelicula, String titulo, String sinopsis, String fechaEstreno, int duracionMin,
                    String idiomaOriginal, String clasificacionEdad, double presupuesto, double recaudacion,
                    int idGeneroPrincipal, Integer idGeneroSecundario, Integer idPeliculaSecuela) {
        this.idPelicula = idPelicula;
        this.titulo = titulo;
        this.sinopsis = sinopsis;
        this.fechaEstreno = fechaEstreno;
        this.duracionMin = duracionMin;
        this.idiomaOriginal = idiomaOriginal;
        this.clasificacionEdad = clasificacionEdad;
        this.presupuesto = presupuesto;
        this.recaudacion = recaudacion;
        this.idGeneroPrincipal = idGeneroPrincipal;
        this.idGeneroSecundario = idGeneroSecundario;
        this.idPeliculaSecuela = idPeliculaSecuela;
    }

    public int getIdPelicula() { return idPelicula; }
    public void setIdPelicula(int idPelicula) { this.idPelicula = idPelicula; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getSinopsis() { return sinopsis; }
    public void setSinopsis(String sinopsis) { this.sinopsis = sinopsis; }
    public String getFechaEstreno() { return fechaEstreno; }
    public void setFechaEstreno(String fechaEstreno) { this.fechaEstreno = fechaEstreno; }
    public int getDuracionMin() { return duracionMin; }
    public void setDuracionMin(int duracionMin) { this.duracionMin = duracionMin; }
    public String getIdiomaOriginal() { return idiomaOriginal; }
    public void setIdiomaOriginal(String idiomaOriginal) { this.idiomaOriginal = idiomaOriginal; }
    public String getClasificacionEdad() { return clasificacionEdad; }
    public void setClasificacionEdad(String clasificacionEdad) { this.clasificacionEdad = clasificacionEdad; }
    public double getPresupuesto() { return presupuesto; }
    public void setPresupuesto(double presupuesto) { this.presupuesto = presupuesto; }
    public double getRecaudacion() { return recaudacion; }
    public void setRecaudacion(double recaudacion) { this.recaudacion = recaudacion; }
    public int getIdGeneroPrincipal() { return idGeneroPrincipal; }
    public void setIdGeneroPrincipal(int idGeneroPrincipal) { this.idGeneroPrincipal = idGeneroPrincipal; }
    public Integer getIdGeneroSecundario() { return idGeneroSecundario; }
    public void setIdGeneroSecundario(Integer idGeneroSecundario) { this.idGeneroSecundario = idGeneroSecundario; }
    public Integer getIdPeliculaSecuela() { return idPeliculaSecuela; }
    public void setIdPeliculaSecuela(Integer idPeliculaSecuela) { this.idPeliculaSecuela = idPeliculaSecuela; }
}
