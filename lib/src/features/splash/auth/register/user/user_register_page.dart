import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/splash/auth/register/user/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final useRegisterVM = ref.watch(userRegisterVmProvider.notifier);
    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStateStatus.error:
          Messages.showError(
            'Erro ao registar usuário administrador',
            context,
          );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Email obrigatório'),
                    Validatorless.email('E-mail inválido')
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: passwordEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatório'),
                    Validatorless.min(
                        6, 'A senha deve conter pelo menos 6 caracteres'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar Senha obrigatório'),
                    Validatorless.compare(
                        passwordEC, 'Senha diferente de confirma senha'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Confirmar Senha'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError(('Formulário inválido'), context);
                      case true:
                        useRegisterVM.register(
                            name: nameEC.text,
                            email: emailEC.text,
                            password: passwordEC.text);
                    }
                  },
                  child: const Text('CRIAR CONTA'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
