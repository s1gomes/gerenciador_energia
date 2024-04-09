import 'package:flutter/material.dart';

enum Imagens {
  cozinha("cozinha", "assets/images/cozinha.jpg"),
  duasMesas("duasMesas", "assets/images/duas_mesas.jpg"),
  graficoBarras("graficoBarras", "assets/images/grafico1.png"),
  graficoLinha("graficoLinha", "assets/images/grafico2.png"),
  mesaCadeiraPreta("mesaCadeiraPreta", "assets/images/mesa_cadeira_preta.jpg"),
  mesaJanela("mesaJanela", "assets/images/mesa_com_janela.jpg"),
  plantaCasa("plantaCasa", "assets/images/planta.jpeg"),
  productImageNoAvailable("productImageNoAvailable",
      "assets/images/product_Fimage_not_available.png"),
  sala("sala", "assets/images/sala.jpg"),
  televisao("televisao", "assets/images/televisao.jpg"),
  ventilador("ventilador", "assets/images/ventilador.jpg");

  const Imagens(this.label, this.url);
  final String label;
  final String url;
}

// List<DropdownMenuItem<String>> get imagensComodosItems {
//   List<DropdownMenuItem<String>> menuImagens = [
//     DropdownMenuItem(value: Imagens.cozinha.toString(), child: Text("Cozinha")),
//     DropdownMenuItem(
//         value: Imagens.plantaCasa.toString(), child: Text("Planta da casa")),
//     DropdownMenuItem(value: Imagens.sala.toString(), child: Text("Sala")),
//   ];
//   return menuImagens;
// }

// String selectedImageComodos = Imagens.plantaCasa.toString();

// class DropDownImagesComodos extends StatefulWidget {
//   const DropDownImagesComodos({super.key});

//   @override
//   State<DropDownImagesComodos> createState() => _DropDownImagesComodosState();
// }

// class _DropDownImagesComodosState extends State<DropDownImagesComodos> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 35,
//       width: 120,
//       child: DropdownButton(
//           style: const TextStyle(color: Colors.black, fontSize: 14),
//           items: imagensComodosItems,
//           value: selectedImageComodos,
//           onChanged: (String? newValue) {
//             setState(() {
//               selectedImageComodos = newValue!;
//             });
//           }),
//     );
//   }
// }



class ImageDropdownMenu extends StatefulWidget {
  const ImageDropdownMenu({super.key});

  static const Map<String, String> imagens = {
    "cozinha": "assets/images/cozinha.jpg",
    "duasMesas": "assets/images/duas_mesas.jpg",
    "graficoBarras": "assets/images/grafico1.png",
    "graficoLinha": "assets/images/grafico2.png",
    "mesaCadeiraPreta": "assets/images/mesa_cadeira_preta.jpg",
    "mesaJanela": "assets/images/mesa_com_janela.jpg",
    "plantaCasa": "assets/images/planta.jpeg",
    "productImageNoAvailable": "assets/images/product_Fimage_not_available.png",
    "sala": "assets/images/sala.jpg",
    "televisao": "assets/images/televisao.jpg",
    "ventilador": "assets/images/ventilador.jpg",
  };

  @override
  State<ImageDropdownMenu> createState() => _ImageDropdownMenuState();




}

class _ImageDropdownMenuState extends State<ImageDropdownMenu> {
  final TextEditingController imageController = TextEditingController();
  Imagens? seletedImage;

  sendImageController () {
    String imagemUrlController;
    imagemUrlController = imageController.text;
    if (imagemUrlController.isNotEmpty) {
      return imagemUrlController;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 150,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: DropdownMenu(
            initialSelection: Imagens.plantaCasa,
            controller: imageController,
            requestFocusOnTap: true,
            label: const Text('Cômodo'),
            onSelected: (Imagens? url) {
              setState(() {
                seletedImage = url;
                sendImageController();
              });
            },
            dropdownMenuEntries: 
            Imagens.values.map<DropdownMenuEntry<Imagens>> ((Imagens url) {
              return DropdownMenuEntry<Imagens>(
                value: url,
                label: url.label,
                enabled: url.label != 'plantaCasa',
              );
            }).toList()
            ),
          ),
        );
  }
}
