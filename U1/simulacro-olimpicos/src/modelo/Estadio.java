package modelo;

public class Estadio {
    private int idEstadio;
    private String nombre;
    private String ciudad;
    private String pais;
    private int aforo;

    public Estadio() {}

    public Estadio(int idEstadio, String nombre, String ciudad, String pais, int aforo) {
        this.idEstadio = idEstadio;
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.pais = pais;
        this.aforo = aforo;
    }

    public Estadio(String nombre, String ciudad, String pais, int aforo) {
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.pais = pais;
        this.aforo = aforo;
    }

    public int getIdEstadio() {
        return idEstadio;
    }

    public void setIdEstadio(int idEstadio) {
        this.idEstadio = idEstadio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public int getAforo() {
        return aforo;
    }

    public void setAforo(int aforo) {
        this.aforo = aforo;
    }

    @Override
    public String toString() {
        return "Estadio{" +
                "id_estadio=" + idEstadio +
                ", nombre='" + nombre + '\'' +
                ", ciudad='" + ciudad + '\'' +
                ", pais='" + pais + '\'' +
                ", aforo=" + aforo +
                '}';
    }
}
