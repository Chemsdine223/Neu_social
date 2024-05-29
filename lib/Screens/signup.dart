import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neu_social/Logic/SignupCubit/signup_cubit.dart';
import 'package:neu_social/Screens/interests_screen.dart';
import 'package:neu_social/Utils/size_config.dart';
import 'package:neu_social/Widgets/Buttons/custom_button.dart';
import 'package:neu_social/Widgets/Inputs/custom_input.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  String? birthDateInString;
  // DateTime? birthDate;
  String? formattedDate;

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, Authentication>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(18)),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: getProportionateScreenHeight(120),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(180),
                            child: Text(
                              'Create Account',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(40)),
                          CustomTextField(
                            controller: firstnameController,
                            hintText: 'Firstname',
                            password: false,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Firstname cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          CustomTextField(
                            controller: lastnameController,
                            hintText: 'Lastname',
                            password: false,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Lastname cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          _dateField(context),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Email',
                            password: false,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'E-mail cannot be empty';
                              } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            password: true,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(18),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      context.read<SignupCubit>().saveUser(
                                          firstnameController.text,
                                          lastnameController.text,
                                          DateTime.parse(
                                              formattedDate.toString()),
                                          emailController.text);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const InterestsScreen(),
                                          ));
                                    }
                                  },
                                  color: Colors.green.shade800,
                                  radius: 24,
                                  height: getProportionateScreenHeight(45),
                                  label: Text(
                                    'Sign up',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // state == Authentication.loading
            //     ? const CustomOverlay()
            //     : Container(),
          ],
        );
      },
    );
  }

  TextFormField _dateField(BuildContext context) {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Date of birth can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'DD/MM/YYYY',
        suffixIcon: GestureDetector(
          child: const Icon(Icons.calendar_today),
          onTap: () async {
            final datePick = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            if (datePick != null) {
              setState(() {
                dobController.text =
                    "${datePick.day}-${datePick.month < 10 ? "0" : ""}${datePick.month}-${datePick.year}";
                formattedDate =
                    "${datePick.year}-${datePick.month < 10 ? "0" : ""}${datePick.month}-${datePick.day}";
              });
            }
          },
        ),
      ),
    );
  }
}