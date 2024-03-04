import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final Widget? page;
  const MenuCard({super.key, required this.svgPath, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio*7,
          vertical: MediaQuery.of(context).devicePixelRatio*2),
      child: InkWell(
        onTap: (){
          if(page != null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => page!,));
          }
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(255, 255, 255, 0.40),
                Color.fromRGBO(255, 255, 255, 0.40),
              ],
              stops: [0.0, 1.0],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.13),
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 22)),
                    SvgPicture.asset(
                      svgPath,
                      width: 70,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 10,
                  child: IconButton(
                    onPressed: (){

                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
