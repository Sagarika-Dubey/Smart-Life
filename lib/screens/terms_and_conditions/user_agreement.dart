import 'package:flutter/material.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SmartLife Terms of Use'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Better navigation handling
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
Welcome to SmartLife!
The SmartLife Terms of Use (hereinafter referred to as "the Terms") govern the relationship and serve as an agreement between you and Volcano Technology Limited and its affiliates (“Volcano”, “we”, “our” or “us”). The Terms set forth the terms and conditions by which you may access and use our software, services, applications, products and content (collectively, the “Services”).
In case of changes to the Terms, we will notify you in the Licensed Software by message to you. Upon notification, the changes are automatically incorporated as a part of the Terms without further notice. If you object to any such changes, please stop your use of the Services; continued usage of the Services will be deemed as agreement to the changes and being bound by them.
I. Definitions of Terms
1.1 “Licensed Software” or “SmartLife” refers to the “SmartLife” mobile App software, including related systems, the Services and applications, developed and licensed by Volcano, which can be downloaded, installed and used on mobile terminals.
II. Services
2.1 SmartLife offers you smart home devices control and management services, by which you can access and manage smart devices on SmartLife, utilize smart features, and achieve interlinkage of smart devices via our smart IoT platform. The Services offered via SmartLife include smart device controls, device management, scene interlinkage, and certain value-added services. Additionally, you may customize or modify specific functions of the Services according to personalized needs.
2.2 Please understand that the Services may be subject to temporary unavailability or suspension due to maintenance or other reasons from time to time, with or without notice.
2.3 Please note that the Licensed Software may be updated from time to time in our discretion, which may be provided either automatically or manually. If you refuse to install the updated version of the Licensed Software, SmartLife and part or all of the Services may not function normally. All such updates will constitute part of the Licensed Software and therefore, subject to the Terms, unless otherwise notified. You agree that there is no guarantee that any such updates will be provided, or that they will remain available or continue to function in connection with your devices or systems.
III. Scope of Service
3.1 Volcano grants you with a limited, revocable, non-transferable, non-exclusive and non-sublicensable right to use the Licensed Software in accordance with the Terms.
3.2 In order to use the Licensed Software and the Services, you may need to register a SmartLife account. You shall accurately provide and timely update your account information to ensure that such information is and will be authentic, complete and accurate. Certain products or services may require further identify information for further identity authentication or qualification, and you may use such products or services only after your SmartLife account passes the authentication or qualification. For more information, please refer to the SmartLife Privacy Policy.
3.3 Please note that the Services are only provided for private, non-commercial use. Any use of the Licensed Software for any commercial purpose, or any license, sale, lease, transfer, or offer of the Services in any form are strictly prohibited. If such commercial operation is necessary, you shall first obtain prior written authorization and permission from Volcano.
3.4 Due to limitations on applicable platforms and mobile terminals, you may use the Licensed Software only on authorized system platforms and terminals; if you install the Licensed Software on other terminals, it may not function properly or even may impact other functions of the hardware or software.
3.5 Volcano and/or its service providers may change, upgrade or transfer the Licensed Software or its relevant functions from time to time, and may add new functions or services to the Licensed Software. If no separate agreements are accompanied with the aforesaid new functions or services, you may use the corresponding functions and services, which is also subject to the Terms.
3.6 You shall be responsible for the accuracy, reliability, integrity and legality of data inputs in the Licensed Software, and shall ensure the lawfulness of your data and the way in which you obtain such data. You are advised to back up all your data from time to time. You shall bear all risks for damage and loss of such data.
3.7 You shall properly maintain security of your account number and password. In case of any safety loophole that may affect your SmartLife account (including but not limited to divulgence of user password), please notify Volcano immediately, and we will assist you in taking relevant measures. Otherwise, all user acts related to your SmartLife account shall be assumed by you and you will be solely liable for such acts.
IV. Third-Party Services
4.1 You acknowledge that some of the Services are based on software or services provided by a third party. Such third-party services are offered for convenience for your use of certain Services, and are subject to necessary legal authorization from the third party.
4.2 You understand that Volcano and its affiliates neither control nor bear any responsibility for information and services of such third parties. We are not liable for any damages or losses arising from your use of such third-party services. Nor do we guarantee their quality, reliability or suitability. You shall comply with any terms and conditions applicable to such third-party services.
4.3 You acknowledge that we cannot guarantee that the Licensed Software will at all times provide or incorporate such third-party services, or that other services provided by the same third parties will be available in the future. Likewise, the Licensed Software may incorporate similar services of other third parties. Your use of the aforesaid third-party services via SmartLife are subject to the Terms.
V. Use of the Services
Your use of the Licensed Software and the Services shall be subject to the following limitations:
5.1 You shall not at any time:
1) publish, disseminate or otherwise share computer virus, worms, malicious codes, or software that deliberately damages or changes computer system or data;
2) collect or process information or data of other users without authorization, for example, email address and the like;
3) use the Licensed Software or the Services in an automated way that may cause overload to our servers, or interfere with or damage web server and network links in other forms;
4) attempt to visit server data or communication data of the product without authorization;
5) interfere with or impact the use of the Licensed Software or the Services by other users.
5.2 You understand and agree that:
1) Volcano will determine whether or not you are involved in any violations set forth above, and suspend or terminate your application license according to determination results or take other restrictions according to agreements.
2) Volcano may directly delete, remove or invalidate any information in breach of laws, or infringing upon others' legitimate rights, or in breach of the Terms issued by you when using the Licensed Software.
3) If a third party suffers from any damages due to your breach hereof, you shall be solely liable to such third party, and you agree to defend and indemnify Volcano against any losses or additional expenses incurred as a result thereof.
5.3 You agree and warrant that you will not conduct any act in breach of laws or improper behaviors by using the Services.
VI. Intellectual Property Rights
6.1 All intellectual property rights in or to SmartLife and any Services (including any future updates, upgrades and new versions), will continue to belong to us and our licensors.
6.2 Save as expressly set forth herein, Volcano does not grant to you any right to use any intellectual property rights, including our trademarks or product names, logos, domain names or other distinctive brand features, without our prior written consent.
6.3 Any comments or feedback provided by you regarding SmartLife are entirely voluntary; you agree that we may freely use such contents at our discretion (including using such comments to improve existing services or create new services) without any payment or other obligation to you.
6.4 To the extent permitted by applicable law, you may not copy, modify, create derivative works, reverse compile, reverse engineer or extract source codes from the Licensed Software, and you may not sell, distribute, redistribute or sublicense the Licensed Software or any Services, without our prior written consent.
VII. Privacy
7.1 At Volcano, we understand and value your privacy, and it is crucial for us to protect your personal information. We have published the SmartLife Privacy Policy (the “Privacy Policy”), which includes contents related to ownership and protection of intellectual property, collection, use, share, storage and protection, etc. of your personal information. We strongly recommend you to thoroughly read the Privacy Policy, which is incorporated as part of the Terms by reference.
VIII. Exception Clauses
8.1 Unless otherwise specified in laws and regulations, Volcano will exercise reasonable care and efforts to deliver to you the Licensed Software and the Services.
8.2 EXCEPT FOR THE FOREGOING, SMARTLIFE AND THE SERVICES ARE PROVIDED ON AN “AS IS” AND “AS AVAILABLE” BASIS AND NEITHER VOLCANO NOR ANY OF OUR AFFILIATES MAKE ANY REPRESENTATION OR WARRANTY IN RELATION TO SMARTLIFE OR THE SERVICES, OR ANY CONTENT, DATA OR INFORMATION CONTAINED THEREIN.
8.4 The development and release of any Licensed Software-derived software not developed and released by Volcano are unauthorized and expressly disclaimed. Please note that any download, installation or use of such software may cause unpredictable risks.
8.5 The usage of the Licensed Software, the Services and any other related services of Volcano may involve internet-based services, and you will need internet access and connection for using the Licensed Software and our Services. Otherwise, they may become unavailable to you. You are responsible for any third-party charges you incur (including any charges from your internet and telecom services providers) in relation to or arising from your use.
IX. Agreement Termination and Breach of Agreement
9.1 You understand that you shall use the Licensed Software according to authorized scope and purpose, and comply with the Terms regarding, without limitation, intellectual property rights, use of Services, and duly observe the Terms when using the Licensed Software and the Services. Volcano may terminate the Services provided to you and/or your license to use Volcano if you are in material breach of any of the Terms. In this case, you shall stop using the Licensed Software and destroy all copies of it, and you agree to indemnify Volcano, its affiliates and/or other users against any loss, damages, costs and liabilities resulting from or related to such breach.
9.2 Your use of the software may be dependent on Services provided by Volcano's affiliates. In case of your breach of the Terms or other agreements with Volcano or our affiliates, we may, either by ourselves or via such affiliates, take certain restrictive measures, including suspension or termination of part or whole of the related Services to you, without liability.
9.3 You agree to use the Licensed Software in accordance with related rules and regulations imposed by operators of corresponding App market or platform, system platform, and smart terminals on use and restrictions of the Licensed Software. If such operators confirm that you are in breach of your agreement with them and requires our assistance or cooperation, Volcano may terminate your application license upon their request.
X. Scope and Limitation of liability
10.1. You understand and agree that you shall undertake the claims of any third party resulting from your use of the Services, any violation of the Terms or any action which takes place under your SmartLife account. If any third party brings any claim against Volcano, its affiliates, employees, customers or partners for this reason, you shall undertake and indemnify Volcano against all the losses and liabilities incurred therefrom.
10.2. To the extent permitted by applicable laws, Volcano is not liable for any indirect, punitive, special or derived loss associated with or arising from the Terms.
10.3. During your use of the Services, you shall abide by applicable laws and regulations and shall not use any of the Services to engage in activities that infringe others’ reputation, privacy, intellectual property or other legitimate rights and interests. We assume no responsibility for your illegal act or default during the use of the Services.
XI. Governing Laws and Severability
11.1 Effectiveness, explanation, change, execution and dispute settlement of the Terms are subject to laws of Hong Kong SAR.
11.2 Any dispute, controversy, difference or claim arising out of or relating to the Terms, including the existence, validity, interpretation, performance, breach or termination thereof or any dispute regarding non- contractual obligations arising out of or relating to them, shall be referred to and finally resolved by arbitration administered by the Hong Kong International Arbitration Centre (HKIAC) under the HKIAC Administered Arbitration Rules in force when the Notice of Arbitration is submitted. The seat of arbitration shall be Hong Kong. The number of arbitrators shall be one. The language of arbitration shall be English.
11.3 If any term of the Terms is judged to be invalid by competent venue, it will not influence the effectiveness of other terms or any other part hereof, and you and Volcano shall perform the valid terms in good faith.
XII. Others
12.1. Volcano may send you notices regarding SmartLife via in-App messages, e-mail, text message, telephone call, etc., Please ensure the accuracy and current validity of your contact information submitted to us; the above notices are deemed to have been delivered upon successful delivery.
12.2 You agree that Volcano may transfer all or part of its rights and obligations under the Terms to an affiliate, which may or may be without notice to you.
12.3 Unless otherwise agreed, for provision of professional services, Volcano may also commission its affiliate or other legal entities to provide certain or all of the Services. In this case, you may conclude relevant terms or conditions with the above company, and you shall carefully read and understand such terms and conditions before choosing to accept them or not.
''',
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
