import 'package:flutter/material.dart';

import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, AuthButtonStyle, AuthButtonType;
import 'package:loading_overlay/loading_overlay.dart';

import 'package:basketprotocol/core/services/auth_service.dart';

import 'package:basketprotocol/core/validators/input_validators.dart';

import 'package:basketprotocol/ui/widgets/alert_widget.dart';

enum ViewMode { login, register, passwordReset }

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailForPasswordResetForm = GlobalKey<FormState>();
  final _emailWithPasswordSignInForm = GlobalKey<FormState>();
  final _emailWithPasswordSignUpForm = GlobalKey<FormState>();

  var _emailInput = '';
  var _passwordInput = '';
  var _passwordConfirmInput = '';

  var _isLoading = false;
  var _isPasswordVisible = false;
  var _isPasswordConfirmVisible = false;

  var _viewMode = ViewMode.login;

  Future<void> _validateAndSignIn() async {
    final _isFormValid = _emailWithPasswordSignInForm.currentState!.validate();

    if (!_isFormValid) {
      return null;
    }

    setState(() => _isLoading = true);

    final response =
        await AuthService().signInWithCredentials(_emailInput, _passwordInput);

    if (response.errorMessage != null) {
      setState(() => _isLoading = false);
      buildAlertWidget(context, 'error', response.errorMessage!);

      return;
    }
  }

  Future<void> _validateAndSignUp() async {
    final _isFormValid = _emailWithPasswordSignUpForm.currentState!.validate();

    if (!_isFormValid) {
      return null;
    }

    setState(() => _isLoading = true);

    final response =
        await AuthService().signUpWithCredentials(_emailInput, _passwordInput);

    if (response.errorMessage != null) {
      setState(() => _isLoading = false);
      buildAlertWidget(context, 'error', response.errorMessage!);

      return;
    }
  }

  Future<void> _validateAndSendPasswordResetLink() async {
    final _isFormValid = _emailForPasswordResetForm.currentState!.validate();

    if (!_isFormValid) {
      return null;
    }

    setState(() => _isLoading = true);

    final response = await AuthService().resetPassword(_emailInput);

    if (response.errorMessage != null) {
      setState(() => _isLoading = false);
      buildAlertWidget(context, 'error', response.errorMessage!);

      return;
    }

    setState(() => _isLoading = false);
  }

  Future<void> _signInAnonymously() async {
    setState(() => _isLoading = true);

    final response = await AuthService().signInAnon();

    if (response.errorMessage != null) {
      setState(() => _isLoading = false);
      buildAlertWidget(context, 'error', response.errorMessage!);

      return;
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    final response = await AuthService().signWithGoogle();

    if (response.errorMessage != null) {
      setState(() => _isLoading = false);
      buildAlertWidget(context, 'error', response.errorMessage!);

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.transparent.withOpacity(.8),
      isLoading: _isLoading,
      child: Scaffold(
        persistentFooterButtons: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            _viewMode = ViewMode.passwordReset;
                          },
                        );
                      },
                      child: Text(
                        'password reset',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            if (_viewMode == ViewMode.login) {
                              _viewMode = ViewMode.register;
                              return;
                            }
                            _viewMode = ViewMode.login;
                          },
                        );
                      },
                      child: Text(
                        _viewMode == ViewMode.login ? 'sign up' : 'sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12.0),
                child: TextButton(
                  onPressed: _signInAnonymously,
                  child: Text(
                    'sign in anonymously',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GoogleAuthButton(
                darkMode: false,
                style: AuthButtonStyle(
                  iconSize: 32.0,
                  buttonType: AuthButtonType.icon,
                ),
                onPressed: _signInWithGoogle,
              ),
            ],
          )
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[_buildBody()],
        ),
      ),
    );
  }

  Form _buildSignInForm() {
    return Form(
      key: _emailWithPasswordSignInForm,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: TextFormField(
              validator: (String? input) => InputValidation.email(input),
              onChanged: (String input) => _emailInput = input,
              decoration: InputDecoration(
                labelText: 'email',
                icon: Icon(Icons.mail_outline),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: TextFormField(
              obscureText: !_isPasswordVisible,
              validator: (String? input) => InputValidation.password(input),
              onChanged: (String input) => _passwordInput = input,
              decoration: InputDecoration(
                labelText: 'password',
                icon: Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  icon: _isPasswordVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: TextButton(
              onPressed: _validateAndSignIn,
              child: Text(
                'sign in',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Form _buildSignUpForm() {
    return Form(
      key: _emailWithPasswordSignUpForm,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: TextFormField(
              validator: (String? input) => InputValidation.email(input),
              onChanged: (String input) => _emailInput = input,
              decoration: InputDecoration(
                labelText: 'email',
                icon: Icon(Icons.mail_outline),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: TextFormField(
              obscureText: !_isPasswordVisible,
              validator: (String? input) => InputValidation.password(input),
              onChanged: (String input) => _passwordInput = input,
              decoration: InputDecoration(
                labelText: 'password',
                icon: Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  icon: _isPasswordVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: TextFormField(
              obscureText: !_isPasswordConfirmVisible,
              validator: (String? input) =>
                  InputValidation.passwordConfirmation(
                      _passwordConfirmInput, _passwordInput),
              onChanged: (String input) => _passwordConfirmInput = input,
              decoration: InputDecoration(
                labelText: 'confirm password',
                icon: Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  icon: _isPasswordConfirmVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () => setState(() =>
                      _isPasswordConfirmVisible = !_isPasswordConfirmVisible),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: TextButton(
              onPressed: _validateAndSignUp,
              child: Text(
                'sign up',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Form _buildPasswordResetForm() {
    return Form(
      key: _emailForPasswordResetForm,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: TextFormField(
              validator: (String? input) => InputValidation.email(input),
              onChanged: (String input) => _emailInput = input,
              decoration: InputDecoration(
                labelText: 'email',
                icon: Icon(Icons.mail_outline),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: TextButton(
              onPressed: _validateAndSendPasswordResetLink,
              child: Text(
                'send password reset link',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_viewMode) {
      case ViewMode.login:
        return _buildSignInForm();
      case ViewMode.register:
        return _buildSignUpForm();
      case ViewMode.passwordReset:
        return _buildPasswordResetForm();
    }
  }
}
