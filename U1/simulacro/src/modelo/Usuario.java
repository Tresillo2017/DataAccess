package modelo;

public class Usuario {
    private int idUsuario;
    private String nombreUsuario;
    private String email;
    private String pais;

    public Usuario() {
    }

    public Usuario(int idUsuario, String nombreUsuario, String email, String pais) {
        this.idUsuario = idUsuario;
        this.nombreUsuario = nombreUsuario;
        this.email = email;
        this.pais = pais;
    }

    public Usuario(String nombreUsuario, String email, String pais) {
        this.nombreUsuario = nombreUsuario;
        this.email = email;
        this.pais = pais;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "idUsuario=" + idUsuario +
                ", nombreUsuario='" + nombreUsuario + '\'' +
                ", email='" + email + '\'' +
                ", pais='" + pais + '\'' +
                '}';
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }
}
