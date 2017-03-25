module mwm_assert(err, ex, modName, msg) {
    if (err)
        echo(str("<b><font color='red'>", ex, "</font> in module '", modName, "' - ", msg, "</b>"));
    else
        children();
}

module arg_out_of_range(err, modName, param, msg) {
    mwm_assert(err, "ARG OUT OF RANGE", modName, str(param, " : ", msg))
        children();
}

module invalid_arg(err, modName, param, msg) {
    mwm_assert(err, "INVALID ARG", modName, str(param, " : ", msg))
        children();
}