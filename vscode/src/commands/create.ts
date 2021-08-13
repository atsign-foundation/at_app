import * as vs from 'vscode';
import { flutterCommandCreate } from '../constants';

export function createCommand() {
  vs.commands.executeCommand(flutterCommandCreate);
}
