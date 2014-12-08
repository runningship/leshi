package org.bc;

import org.bc.sdak.ExceptionType;

public enum PlatformExceptionType implements ExceptionType{
	MethodReturnTypeError,
	ModuleInvokeError,
	MethodParameterError,
	ParameterMissingError,
	ParameterTypeError,
	UserOfflineException,
	BusinessException
}
