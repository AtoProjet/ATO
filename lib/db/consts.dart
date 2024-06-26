import 'dart:ffi';

const String conditions1 = ''
    '1) Safety and security conditions'
    '\n    - Users should install security updates regularly.'
    '\n    - Users should choose strong passwords and not share them with others.'
    '\n 2) Technical support conditions'
    '\n    -We may ask users to provide additional information or bug reports to better provide support.'
    '\n3) License conditions'
    '\n    -The program is licensed for personal use only and may not be distributed or sold.'
    '\n4) Privacy terms'
     '\n    -We respect the privacy of our users and collect their personal data only for specific purposes such as improving the user experience.'
     '\n    -We will not sell or share user data with third parties without prior consent from the user.'
     '\n    -The user has the right to access his personal data and request its modification or deletion.'
     '\n5) Intellectual property conditions'
     '\n    - Some developers may prohibit users from modifying or reproducing the software without written consent.'
     '\n    - Some developers may prohibit users from using their trademarks in any marketing or advertising materials.'
     '\n6) Terms of use'
     '\n    -Users are prohibited from posting or sharing any content that is considered offensive or inappropriate, including images or texts that contain an element of abuse, hatred, or violence.'
     '\n    -Users must not post or share copyrighted content without obtaining appropriate permission from the right holder.'
     '\n    -It is prohibited to use the program for any fraudulent or fraudulent activities, including creating fake accounts or falsifying personal information.'
     '\n    -It is prohibited to use the program to download or spread malicious software such as viruses, spyware, or other malicious software.'
     '\n    -Users must deal in good faith with other users and not incite hatred, discriminatio or violence.;';
const String conditions2 =
    '\n1. Goals and Purpose: The ATO program aims to make those in need feel the shopping experience without feeling embarrassed and to improve the lives of people in need.'
    '\n2. Qualifications and Conditions: The user, especially the donor in the program, must be 18 years of age or older.'
    '\n3. Responsibilities and Obligations: Users are required to provide true and accurate information about themselves and not share the data with anyone else.'
    '\n4. Permitted use: It is prohibited to use the program for illegal purposes or to carry out any activity that conflicts with local or international laws.'
    '\n5. Privacy and Personal Data: Personal data is collected only to process donations and is not shared with third parties without explicit consent.'
    '\n6. Intellectual Property: The program reserves the intellectual property rights to all content available through it, and the use of this content without permission is prohibited.'
    '\n7. Indemnifications and Warranties: Users bear full responsibility for any unauthorized use of the Software and the Software does not provide any express or implied warranties.'
    '\n8. Changes and Cancellations: The program reserves the right to change the terms of use and its policies at any time without prior notice.'
    '\n9. Legal Resolutions: Use of the Software is subject to the laws and regulations of the country in which it is used, and in the event of disputes they are settled by applicable laws.'
    '\n10. Communication and Support: Users can communicate with the support team via the chat in the program to solve any questions or problems they face.';

const toyCat= "toys";
const clothCat= "clothes";
const bookCat= "books";
const shoesCat= "shoes";
const bagsCat= "bags";
const List<String> categories = [toyCat, clothCat, bookCat, bagsCat, shoesCat];
const List<String> genders= ["men", "women", "children"];
final List<String> usSizes = ["XS", "S", "M", "L", "XL"];
final List<String> ukSizes = List.generate(42, (index) => "${index + 4}");

