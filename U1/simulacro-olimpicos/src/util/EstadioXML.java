package util;

import java.io.File;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import modelo.Estadio;

public class EstadioXML {

    // Exporta la lista de estadios a un fichero XML. Devuelve true si todo ha ido bien
    public static boolean exportarEstadios(ArrayList<Estadio> estadios, String ruta) {

        try {
            // PASO 1. Documento XML vacío en memoria
            DocumentBuilderFactory fabrica = DocumentBuilderFactory.newInstance();
            DocumentBuilder constructor = fabrica.newDocumentBuilder();
            Document documento = constructor.newDocument();

            // PASO 2. Elemento raíz <estadios>
            Element raiz = documento.createElement("estadios");
            documento.appendChild(raiz);

            // PASO 3. Un <estadio> por cada objeto de la lista
            for (Estadio e : estadios) {
                Element elementoEstadio = documento.createElement("estadio");
                raiz.appendChild(elementoEstadio);

                crearElemento(documento, elementoEstadio, "id", String.valueOf(e.getIdEstadio()));
                crearElemento(documento, elementoEstadio, "nombre", e.getNombre());
                crearElemento(documento, elementoEstadio, "ciudad", e.getCiudad());
                crearElemento(documento, elementoEstadio, "pais", e.getPais());
                crearElemento(documento, elementoEstadio, "aforo", String.valueOf(e.getAforo()));
            }

            // PASO 4. Crear la carpeta si no existe
            File archivo = new File(ruta);
            File carpeta = archivo.getParentFile();

            if (carpeta != null && !carpeta.exists() && !carpeta.mkdirs()) {
                System.out.println("No se pudo crear la carpeta de exportación");
                return false;
            }

            // PASO 5. Guardar el documento en el fichero
            Transformer transformador = TransformerFactory.newInstance().newTransformer();
            transformador.setOutputProperty(OutputKeys.INDENT, "yes");
            transformador.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformador.transform(new DOMSource(documento), new StreamResult(archivo));

            return true;

        } catch (Exception ex) {
            System.out.println("Error al crear el documento XML: " + ex.getMessage());
            return false;
        }
    }

    // Método auxiliar: crea <nombreEtiqueta>valor</nombreEtiqueta> dentro del padre
    private static void crearElemento(Document documento, Element padre, String nombreEtiqueta, String valor) {
        Element elemento = documento.createElement(nombreEtiqueta);
        elemento.setTextContent(valor);
        padre.appendChild(elemento);
    }

    // Lee el fichero XML y muestra los estadios por pantalla
    public static void leerXML(String ruta) {

        File archivo = new File(ruta);

        if (!archivo.exists()) {
            System.out.println("El fichero XML no existe");
            return;
        }

        try {
            DocumentBuilderFactory fabrica = DocumentBuilderFactory.newInstance();
            DocumentBuilder constructor = fabrica.newDocumentBuilder();
            Document documento = constructor.parse(archivo);

            NodeList listaEstadios = documento.getElementsByTagName("estadio");

            for (int i = 0; i < listaEstadios.getLength(); i++) {
                Element elementoEstadio = (Element) listaEstadios.item(i);

                String id = leerEtiqueta(elementoEstadio, "id");
                String nombre = leerEtiqueta(elementoEstadio, "nombre");
                String ciudad = leerEtiqueta(elementoEstadio, "ciudad");
                String pais = leerEtiqueta(elementoEstadio, "pais");
                String aforo = leerEtiqueta(elementoEstadio, "aforo");

                System.out.println("-------------------------");
                System.out.println("ID: " + id);
                System.out.println("Nombre: " + nombre);
                System.out.println("Ciudad: " + ciudad);
                System.out.println("País: " + pais);
                System.out.println("Aforo: " + aforo);
            }
            System.out.println("-------------------------");
            System.out.println(listaEstadios.getLength() + " estadios leídos del XML");

        } catch (Exception ex) {
            // Cubre XML mal formado (SAXException) y errores de lectura (IOException)
            System.out.println("Error al leer el fichero XML: " + ex.getMessage());
        }
    }

    // Devuelve el texto de una etiqueta hija, o "?" si falta (XML con estructura incorrecta)
    private static String leerEtiqueta(Element padre, String etiqueta) {
        NodeList nodos = padre.getElementsByTagName(etiqueta);
        if (nodos.getLength() == 0) {
            return "?";
        }
        return nodos.item(0).getTextContent();
    }
}
