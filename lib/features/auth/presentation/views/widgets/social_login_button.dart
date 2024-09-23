import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key, required this.text, required this.svgIconPath, required this.onPressed});
  final String text;
  final String svgIconPath;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          side: const BorderSide(color: Color(0xffDDDFDF) , ), // Border color
          
          padding: const EdgeInsets.all(8), 
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Border radius
        ),
        ),
        
        child: ListTile(
       dense: true,
        leading: SvgPicture.asset(
          svgIconPath,
          height: 24, // Adjust icon height
          width: 24,  // Adjust icon width
        ),
        
        title: Center(
          child: Text(
            text,
            style: TextStyles.semiBold16, // Text style
            
          ),
        ),
        
       
      ),
      )
    );
      
    
  }
}